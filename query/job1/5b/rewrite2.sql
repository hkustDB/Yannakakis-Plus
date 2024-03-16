create or replace view aggView3077550804331275954 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin7053845984720763429 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView3077550804331275954 where mc.movie_id=aggView3077550804331275954.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView1573716655531365180 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1883327401284730243 as select v15, v9, v27 from aggJoin7053845984720763429 join aggView1573716655531365180 using(v1);
create or replace view aggView4192359201238114369 as select v15, MIN(v27) as v27 from aggJoin1883327401284730243 group by v15;
create or replace view aggJoin1159635208114279867 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4192359201238114369 where mi.movie_id=aggView4192359201238114369.v15 and info IN ('USA','America');
create or replace view aggView7403688891802005171 as select id as v3 from info_type as it;
create or replace view aggJoin8157456300001890279 as select v13, v27 from aggJoin1159635208114279867 join aggView7403688891802005171 using(v3);
select MIN(v27) as v27 from aggJoin8157456300001890279;
