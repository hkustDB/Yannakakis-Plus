create or replace view aggView6356618377287706759 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2638109966480977876 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6356618377287706759 where mc.company_type_id=aggView6356618377287706759.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView9070659045993456541 as select v15, COUNT(*) as annot from aggJoin2638109966480977876 group by v15;
create or replace view aggJoin3930298363320814948 as select movie_id as v15, info_type_id as v3, info as v13, annot from movie_info as mi, aggView9070659045993456541 where mi.movie_id=aggView9070659045993456541.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView71862459884439152 as select id as v3 from info_type as it;
create or replace view aggJoin7745149621795383467 as select v15, v13, annot from aggJoin3930298363320814948 join aggView71862459884439152 using(v3);
create or replace view aggView8593746927371151078 as select v15, SUM(annot) as annot from aggJoin7745149621795383467 group by v15;
create or replace view aggJoin1569095654908270369 as select annot from title as t, aggView8593746927371151078 where t.id=aggView8593746927371151078.v15 and production_year>1990;
select SUM(annot) as v27 from aggJoin1569095654908270369;
