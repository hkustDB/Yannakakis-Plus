create or replace view aggView2434461485060508272 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3834606594082970269 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2434461485060508272 where mc.company_type_id=aggView2434461485060508272.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView2581526186338671730 as select v15 from aggJoin3834606594082970269 group by v15;
create or replace view aggJoin7536003758697331617 as select id as v15, title as v16, production_year as v19 from title as t, aggView2581526186338671730 where t.id=aggView2581526186338671730.v15 and production_year>2005;
create or replace view aggView4163971156049189097 as select id as v3 from info_type as it;
create or replace view aggJoin1669748959728070561 as select movie_id as v15, info as v13 from movie_info as mi, aggView4163971156049189097 where mi.info_type_id=aggView4163971156049189097.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4427769871710663972 as select v15 from aggJoin1669748959728070561 group by v15;
create or replace view aggJoin7185716496600794058 as select v16 from aggJoin7536003758697331617 join aggView4427769871710663972 using(v15);
select MIN(v16) as v27 from aggJoin7185716496600794058;
