create or replace view aggJoin409889873307267852 as (
with aggView5618645486191448824 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView5618645486191448824 where mc.company_id=aggView5618645486191448824.v20);
create or replace view aggJoin1397356316622013325 as (
with aggView3697001947497555569 as (select v3 from aggJoin409889873307267852 group by v3)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView3697001947497555569 where ci.movie_id=aggView3697001947497555569.v3);
create or replace view aggJoin7589117557686434003 as (
with aggView8828247619878473283 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView8828247619878473283 where mk.keyword_id=aggView8828247619878473283.v25);
create or replace view aggJoin4558608777437901541 as (
with aggView8553509428131341030 as (select id as v3 from title as t)
select v3 from aggJoin7589117557686434003 join aggView8553509428131341030 using(v3));
create or replace view aggJoin5090419487383058926 as (
with aggView8379075308820657328 as (select v3 from aggJoin4558608777437901541 group by v3)
select v26 from aggJoin1397356316622013325 join aggView8379075308820657328 using(v3));
create or replace view aggJoin6870576026546576535 as (
with aggView3024135400928783795 as (select v26 from aggJoin5090419487383058926 group by v26)
select name as v27 from name as n, aggView3024135400928783795 where n.id=aggView3024135400928783795.v26 and name LIKE 'B%');
create or replace view aggView7202372794361922959 as select v27 from aggJoin6870576026546576535 group by v27;
select MIN(v27) as v47 from aggView7202372794361922959;
