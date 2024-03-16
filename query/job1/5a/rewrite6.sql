create or replace view aggView6563707895968394880 as select id as v3 from info_type as it;
create or replace view aggJoin71311578064296918 as select movie_id as v15, info as v13 from movie_info as mi, aggView6563707895968394880 where mi.info_type_id=aggView6563707895968394880.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2420797237943412180 as select v15 from aggJoin71311578064296918 group by v15;
create or replace view aggJoin8652228462453851075 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView2420797237943412180 where mc.movie_id=aggView2420797237943412180.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView1974166674744641563 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2991327247201491152 as select v15, v9 from aggJoin8652228462453851075 join aggView1974166674744641563 using(v1);
create or replace view aggView4040369735640277177 as select v15 from aggJoin2991327247201491152 group by v15;
create or replace view aggJoin6861807454239250541 as select title as v16 from title as t, aggView4040369735640277177 where t.id=aggView4040369735640277177.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin6861807454239250541;
