create or replace view aggView4579532561504754155 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin992227721832209269 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4579532561504754155 where mi.movie_id=aggView4579532561504754155.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5435895454424657889 as select id as v3 from info_type as it;
create or replace view aggJoin1521242610747223330 as select v15, v13, v27 from aggJoin992227721832209269 join aggView5435895454424657889 using(v3);
create or replace view aggView303470560861444236 as select v15, MIN(v27) as v27 from aggJoin1521242610747223330 group by v15;
create or replace view aggJoin6463524334873848359 as select company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView303470560861444236 where mc.movie_id=aggView303470560861444236.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView1743214484126987866 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7675171190095113638 as select v9, v27 from aggJoin6463524334873848359 join aggView1743214484126987866 using(v1);
select MIN(v27) as v27 from aggJoin7675171190095113638;
