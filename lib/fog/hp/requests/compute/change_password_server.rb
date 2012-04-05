module Fog
  module Compute
    class HP
      class Real

        def change_password_server(server_id, admin_password)
          body = { 'changePassword' => { 'adminPass' => admin_password }}
          server_action(server_id, body)
        end

      end

      class Mock

        def change_password_server(server_id, admin_password)
          response = Excon::Response.new
          if list_servers_detail.body['servers'].detect {|_| _['id'] == server_id}
            if admin_password
              response.body = { 'changePassword' => { 'adminPass' => admin_password }}
            end
            response.status = 202
            response
          else
            raise Fog::Compute::HP::NotFound
          end
        end

      end
    end
  end
end
