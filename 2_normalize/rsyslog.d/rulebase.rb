version=2
type=@ip:%..:ipv4%
type=@ip:%..:ipv6%
type=@process:%name:char-to:[\x3a%[%pid:number%]
type=@process:%name:char-to:\x3a%

# TODO extract informations from 'message' field
prefix=<%priority:number%>%timestamp:date-rfc3164{"format": "timestamp-unix"}% %hostname:char-to: % %process:@process%:
rule=:%-:whitespace%%message:rest%
