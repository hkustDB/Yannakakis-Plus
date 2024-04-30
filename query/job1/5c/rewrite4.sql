create or replace view aggView3403062428655403851 as select id as v3 from info_type as it;
create or replace view aggJoin1821152340988773665 as select movie_id as v15, info as v13 from movie_info as mi, aggView3403062428655403851 where mi.info_type_id=aggView3403062428655403851.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2079145247039432357 as select v15 from aggJoin1821152340988773665 group by v15;
create or replace view aggJoin4468057732241672477 as select id as v15, title as v16, production_year as v19 from title as t, aggView2079145247039432357 where t.id=aggView2079145247039432357.v15 and production_year>1990;
create or replace view aggView5523406570673642400 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4830035519490105970 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5523406570673642400 where mc.company_type_id=aggView5523406570673642400.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView8653545912851245017 as select v15 from aggJoin4830035519490105970 group by v15;
create or replace view aggJoin2054600364435345391 as select v16 from aggJoin4468057732241672477 join aggView8653545912851245017 using(v15);
select MIN(v16) as v27 from aggJoin2054600364435345391;
