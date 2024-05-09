create or replace view aggView8153303921134003874 as select id as v3 from info_type as it;
create or replace view aggJoin4032021492372915103 as select movie_id as v15, info as v13 from movie_info as mi, aggView8153303921134003874 where mi.info_type_id=aggView8153303921134003874.v3 and info IN ('USA','America');
create or replace view aggView6462038480471048481 as select v15, COUNT(*) as annot from aggJoin4032021492372915103 group by v15;
create or replace view aggJoin8010712270493888928 as select id as v15, production_year as v19, annot from title as t, aggView6462038480471048481 where t.id=aggView6462038480471048481.v15 and production_year>2010;
create or replace view aggView6413594067779820547 as select v15, SUM(annot) as annot from aggJoin8010712270493888928 group by v15;
create or replace view aggJoin4559499716741387900 as select company_type_id as v1, note as v9, annot from movie_companies as mc, aggView6413594067779820547 where mc.movie_id=aggView6413594067779820547.v15 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView1659847847812766047 as select v1, SUM(annot) as annot from aggJoin4559499716741387900 group by v1;
create or replace view aggJoin981935295270362531 as select kind as v2, annot from company_type as ct, aggView1659847847812766047 where ct.id=aggView1659847847812766047.v1 and kind= 'production companies';
select SUM(annot) as v27 from aggJoin981935295270362531;
