<?php

declare(strict_types=1);

namespace XoopsModules\Wgtransifex\Tests;

use PHPUnit\Framework\TestCase;
use XoopsModules\Wgtransifex\TransifexLib;

class TransifexLibTest extends TestCase
{
    public function testGetProjectsTransformsResponse(): void
    {
        $client = new TransifexLib();
        $client->configure('xoops', 'token');
        $responses = [
            [
                'status' => 200,
                'body' => \json_encode([
                    'data' => [
                        [
                            'id' => 'o:xoops:p:test',
                            'attributes' => [
                                'slug' => 'test',
                                'name' => 'Test Project',
                                'description' => 'Desc',
                                'archived' => false,
                                'source_language_code' => 'en',
                                'datetime_modified' => '2024-01-01T00:00:00Z',
                            ],
                        ],
                    ],
                    'links' => ['next' => null],
                ]),
                'error' => null,
            ],
        ];
        $client->setHttpClient($this->queueHttpClient($responses));

        $projects = $client->getProjects();

        $this->assertCount(1, $projects);
        $this->assertSame('test', $projects[0]['slug']);
        $this->assertSame('Test Project', $projects[0]['name']);
        $this->assertSame('en', $projects[0]['source_language_code']);
    }

    public function testGetProjectsThrowsExceptionWhenHttpError(): void
    {
        $client = new TransifexLib();
        $client->configure('xoops', 'token');
        $responses = [
            [
                'status' => 401,
                'body' => \json_encode(['errors' => [['detail' => 'Unauthorized']]]),
                'error' => null,
            ],
        ];
        $client->setHttpClient($this->queueHttpClient($responses));

        $this->expectException(\RuntimeException::class);
        $this->expectExceptionMessage('Unauthorized');
        $client->getProjects();
    }

    public function testGetProjectIncludesResourcesWhenDetailsRequested(): void
    {
        $client = new TransifexLib();
        $client->configure('xoops', 'token');
        $responses = [
            [
                'status' => 200,
                'body' => \json_encode([
                    'data' => [
                        'id' => 'o:xoops:p:test',
                        'attributes' => [
                            'slug' => 'test',
                            'name' => 'Test',
                            'description' => 'Desc',
                            'archived' => false,
                            'source_language_code' => 'en',
                            'datetime_modified' => '2024-01-01T00:00:00Z',
                        ],
                        'relationships' => [
                            'teams' => [
                                'data' => [
                                    ['id' => 't:core'],
                                ],
                            ],
                        ],
                    ],
                ]),
                'error' => null,
            ],
            [
                'status' => 200,
                'body' => \json_encode([
                    'data' => [
                        [
                            'id' => 'o:xoops:p:test:r:resource',
                            'attributes' => [
                                'slug' => 'resource',
                                'name' => 'Resource',
                                'i18n_type' => 'PO',
                                'priority' => 0,
                                'source_language_code' => 'en',
                                'categories' => [],
                                'metadata' => [],
                            ],
                        ],
                    ],
                    'links' => ['next' => null],
                ]),
                'error' => null,
            ],
        ];
        $client->setHttpClient($this->queueHttpClient($responses));

        $project = $client->getProject('test', true);

        $this->assertSame('test', $project['slug']);
        $this->assertCount(1, $project['resources']);
        $this->assertSame('resource', $project['resources'][0]['slug']);
        $this->assertSame([['id' => 't:core']], $project['teams']);
    }

    public function testGetTranslationDecodesBase64Content(): void
    {
        $client = new TransifexLib();
        $client->configure('xoops', 'token');
        $responses = [
            [
                'status' => 200,
                'body' => \json_encode([
                    'data' => [
                        [
                            'attributes' => [
                                'content' => \base64_encode('example'),
                                'content_encoding' => 'base64',
                                'content_type' => 'text/plain',
                            ],
                        ],
                    ],
                ]),
                'error' => null,
            ],
        ];
        $client->setHttpClient($this->queueHttpClient($responses));

        $translation = $client->getTranslation('project', 'resource', 'de', 'en');

        $this->assertSame('example', $translation['content']);
        $this->assertSame('text/plain', $translation['mimetype']);
    }

    /**
     * @param array<int, array<string, mixed>> $responses
     */
    private function queueHttpClient(array $responses): callable
    {
        return function (string $method, string $url, array $headers, ?string $payload) use (&$responses): array {
            $this->assertNotEmpty($responses, 'No HTTP responses queued for request: ' . $method . ' ' . $url);
            $response = \array_shift($responses);
            $this->assertArrayHasKey('status', $response);
            $this->assertArrayHasKey('body', $response);
            if (!\array_key_exists('error', $response)) {
                $response['error'] = null;
            }

            return $response;
        };
    }
}
