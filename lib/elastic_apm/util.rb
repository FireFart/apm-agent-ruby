# frozen_string_literal: true

module ElasticAPM
  # @api private
  module Util
    def self.micros(target = Time.now)
      utc = target.utc
      utc.to_i * 1_000_000 + utc.usec
    end

    def self.monotonic_micros
      Process.clock_gettime(Process::CLOCK_MONOTONIC, :microsecond)
    end

    def self.git_sha
      sha = `git rev-parse --verify HEAD 2>&1`.chomp
      $?&.success? ? sha : nil
    end

    def self.hex_to_bits(str)
      str.hex.to_s(2).rjust(str.size * 4, '0')
    end

    def self.reverse_merge!(first, *others)
      others.reduce(first) do |curr, other|
        curr.merge!(other) { |_, _, new| new }
      end
    end

    def self.truncate(value, max_length: 1024)
      return unless value
      return value if value.length <= max_length

      value[0...(max_length - 1)] + '…'
    end
  end
end
