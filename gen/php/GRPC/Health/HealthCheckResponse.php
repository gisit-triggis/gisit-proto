<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# NO CHECKED-IN PROTOBUF GENCODE
# source: health/v1/health.proto

namespace GRPC\Health;

use Google\Protobuf\Internal\GPBType;
use Google\Protobuf\Internal\RepeatedField;
use Google\Protobuf\Internal\GPBUtil;

/**
 * Generated from protobuf message <code>health.HealthCheckResponse</code>
 */
class HealthCheckResponse extends \Google\Protobuf\Internal\Message
{
    /**
     * Generated from protobuf field <code>.health.HealthCheckResponse.ServingStatus status = 1;</code>
     */
    protected $status = 0;

    /**
     * Constructor.
     *
     * @param array $data {
     *     Optional. Data for populating the Message object.
     *
     *     @type int $status
     * }
     */
    public function __construct($data = NULL) {
        \GRPC\Health\GPBMetadata\Health::initOnce();
        parent::__construct($data);
    }

    /**
     * Generated from protobuf field <code>.health.HealthCheckResponse.ServingStatus status = 1;</code>
     * @return int
     */
    public function getStatus()
    {
        return $this->status;
    }

    /**
     * Generated from protobuf field <code>.health.HealthCheckResponse.ServingStatus status = 1;</code>
     * @param int $var
     * @return $this
     */
    public function setStatus($var)
    {
        GPBUtil::checkEnum($var, \GRPC\Health\HealthCheckResponse\ServingStatus::class);
        $this->status = $var;

        return $this;
    }

}

