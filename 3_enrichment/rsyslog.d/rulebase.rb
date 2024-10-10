version=2
type=@ip:%..:ipv4%
type=@ip:%..:ipv6%
type=@op_response_bytes:%..:number%
type=@op_response_bytes:%-:quoted-string%

prefix=%src_ip:@ip% - %username:word% [%day:char-to:/%/%str_month:char-to:/%/%year:char-to::%:%time:char-to: % %tz:char-to:]%]%-:whitespace%
rule=:"%http_request_method:word% %url_original:char-to: % HTTP/%http_version:char-to:"%" %http_response_status_code:number% %http_response_body_bytes:@op_response_bytes% %http_request_referrer:op-quoted-string% %user_agent:op-quoted-string% %event_duration:number%
