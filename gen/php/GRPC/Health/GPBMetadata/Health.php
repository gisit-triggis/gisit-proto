<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# NO CHECKED-IN PROTOBUF GENCODE
# source: health/v1/health.proto

namespace GRPC\Health\GPBMetadata;

class Health
{
    public static $is_initialized = false;

    public static function initOnce() {
        $pool = \Google\Protobuf\Internal\DescriptorPool::getGeneratedPool();

        if (static::$is_initialized == true) {
          return;
        }
        $pool->internalAddGeneratedFile(
            "\x0A\xEA\x02\x0A\x16health/v1/health.proto\x12\x06health\"%\x0A\x12HealthCheckRequest\x12\x0F\x0A\x07service\x18\x01 \x01(\x09\"\x8C\x01\x0A\x13HealthCheckResponse\x129\x0A\x06status\x18\x01 \x01(\x0E2).health.HealthCheckResponse.ServingStatus\":\x0A\x0DServingStatus\x12\x0B\x0A\x07UNKNOWN\x10\x00\x12\x0B\x0A\x07SERVING\x10\x01\x12\x0F\x0A\x0BNOT_SERVING\x10\x022J\x0A\x06Health\x12@\x0A\x05Check\x12\x1A.health.HealthCheckRequest\x1A\x1B.health.HealthCheckResponseB>Z\x14./health/v1;healthv1\xCA\x02\x0BGRPC\\Health\xE2\x02\x17GRPC\\Health\\GPBMetadatab\x06proto3"
        , true);

        static::$is_initialized = true;
    }
}

