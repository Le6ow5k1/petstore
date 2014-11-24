require 'petstore/resource'

module Petstore
  module Resources
    class Pets < Petstore::Resource
      set_path 'pet'

      def get(id)
        super
      end

      def find_by_status(status)
        Petstore::Request.new(conn: conn, partial_path: partial_path('findByStatus'),
                              method: :get, params: {status: status.to_s}).make
      end

      def find_by_tags(tags)
        Petstore::Request.new(conn: conn, partial_path: partial_path('findByTags'),
                              method: :get, params: {tags: "#{tags.join(',')}"}).make
      end

      def upload_image(image_path)
        Petstore::Request.new(conn: conn, partial_path: partial_path('uploadImage'),
                              method: :multipart_post, params: {file: image_path}).make
      end
    end
  end
end