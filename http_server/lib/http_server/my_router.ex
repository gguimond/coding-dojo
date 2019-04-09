defmodule HTTPServer.MyRouter do
	use Plug.Router

	plug :match
	plug Plug.Parsers, parsers: [:json], json_decoder: Poison
	plug :dispatch

	get "/" do
		conn
		|> put_resp_content_type("text/html")
		|> send_resp(200, "<html><body><p>Hello World!</p></body></html>")
	end

	post "/" do
		case conn.body_params do
			%{"params" => params} -> send_resp(conn, 200, Map.get(params, "foo"))
			_ -> send_resp(conn, 500, "Internal error")
				
		end
	end

	match _ do
		send_resp(conn, 404, "Page Not Found")
	end
end