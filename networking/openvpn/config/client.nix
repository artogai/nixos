protocol: host: port: ca: cert: key: tlsCrypt: ''
  client
  proto ${protocol}
  ${(if (protocol == "tcp") then "socket-flags TCP_NODELAY" else "")}
  port ${toString port}
  remote ${host}
  dev tun

  ca ${ca}
  cert ${cert}
  key ${key}

  tls-version-min 1.2
  #data channel cipher
  cipher AES-128-GCM
  # TLS 1.3 encryption settings
  tls-ciphersuites TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256
  # TLS 1.2 encryption settings
  tls-cipher TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256:TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256:TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256:TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256
  ecdh-curve secp384r1
  tls-client #be the client side of the TLS handshake
  tls-cert-profile preferred #require certificates to use modern key sizes and signatures
  remote-cert-tls server #require server certificates to have the correct extended key usage
  verify-x509-name ${host} name

  tls-crypt ${tlsCrypt}
''
