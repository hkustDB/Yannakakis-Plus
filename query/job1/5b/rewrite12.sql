create or replace view aggView921217084146544168 as select id as v3 from info_type as it;
create or replace view aggJoin952379673939124138 as select movie_id as v15, info as v13 from movie_info as mi, aggView921217084146544168 where mi.info_type_id=aggView921217084146544168.v3 and info IN ('USA','America');
create or replace view aggView7895310825673739231 as select v15 from aggJoin952379673939124138 group by v15;
create or replace view aggJoin7502688939263702108 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView7895310825673739231 where mc.movie_id=aggView7895310825673739231.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView1077108259424628301 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8209379502200165932 as select v15, v9 from aggJoin7502688939263702108 join aggView1077108259424628301 using(v1);
create or replace view aggView1311932133625394914 as select v15 from aggJoin8209379502200165932 group by v15;
create or replace view aggJoin1630991017709659949 as select title as v16 from title as t, aggView1311932133625394914 where t.id=aggView1311932133625394914.v15 and production_year>2010;
select MIN(v16) as v27 from aggJoin1630991017709659949;
