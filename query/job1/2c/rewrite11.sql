create or replace view aggView5604688709003903989 as select id as v12, title as v31 from title as t;
create or replace view aggJoin8292363677038457587 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView5604688709003903989 where mc.movie_id=aggView5604688709003903989.v12;
create or replace view aggView4281495842266915121 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin6364578604441518128 as select v12, v31 from aggJoin8292363677038457587 join aggView4281495842266915121 using(v1);
create or replace view aggView4570715137198995888 as select v12, MIN(v31) as v31 from aggJoin6364578604441518128 group by v12;
create or replace view aggJoin6181910761851387078 as select keyword_id as v18, v31 from movie_keyword as mk, aggView4570715137198995888 where mk.movie_id=aggView4570715137198995888.v12;
create or replace view aggView5513575219215205951 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1201190183953398988 as select v31 from aggJoin6181910761851387078 join aggView5513575219215205951 using(v18);
select MIN(v31) as v31 from aggJoin1201190183953398988;
