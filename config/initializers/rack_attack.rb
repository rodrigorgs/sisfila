# class Rack::Attack
#   Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 
  
#   Rack::Attack.throttled_response = lambda do |request|
#     [ 429, {}, [<<-EOT
# <!DOCTYPE html>
# <html lang="pt-BR">
#   <head>
#     <meta charset="utf-8">
#     <title>Bloqueado</title>
#   </head>
#   <body>
#     Você fez muitas requisições. Tente novamente mais tarde.
#   </body>
# </html>
# EOT
# ]]
#   end

#   LEVELS = [
#     [5, 20.minutes], # 5 requisições a cada 20 minutos
#     [8, 1.hour],
#     [11, 3.hours],
#     [14, 9.hours],
#     [17, 27.hours]
#   ]

#   LEVELS.each do |level|
#     throttle("inscricoes guest na fila por ip - nivel #{level}", limit: level[0], period: level[1]) do |req|
#       if req.path == '/inscricao' && req.post?
#         req.ip
#       end
#     end
#   end  
# end
