select 
    volume
  , count(distinct 
      case when audit_user = -1 
        then cast(audit_ip as varchar(20))
        else cast(audit_user as varchar(10)) end) as usrcnt 
from audit.slot s inner join container c on s.container = c.id 
where audit_action = 'open' 
group by volume
