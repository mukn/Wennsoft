-- Security assignment user role
select 
	u.USERID,
	u.SECURITYROLEID,
	r.SECURITYROLENAME,
	r.SECURITYROLEDESC
	--,*
from 
	DYNAMICS..SY10500 AS u -- Security assignment user role
	LEFT OUTER JOIN
	DYNAMICS..SY09100 AS r -- Security roles master
		ON u.SECURITYROLEID = r.SECURITYROLEID
where
	u.Cmpanyid = 1
order by
	u.USERID
