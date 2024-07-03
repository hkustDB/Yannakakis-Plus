create or replace view aggView1402889466749170246 as select id as v3 from info_type as it;
create or replace view aggJoin5849064429101906005 as select movie_id as v15, info as v13 from movie_info as mi, aggView1402889466749170246 where mi.info_type_id=aggView1402889466749170246.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1104344345341458610 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5507895462462160239 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1104344345341458610 where mc.company_type_id=aggView1104344345341458610.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView7651840503057377345 as select v15 from aggJoin5849064429101906005 group by v15;
create or replace view aggJoin4773973187645872113 as select id as v15, title as v16, production_year as v19 from title as t, aggView7651840503057377345 where t.id=aggView7651840503057377345.v15 and production_year>2005;
create or replace view aggView7811851801136959766 as select v15 from aggJoin5507895462462160239 group by v15;
create or replace view aggJoin982713251665043291 as select v16 from aggJoin4773973187645872113 join aggView7811851801136959766 using(v15);
select MIN(v16) as v27 from aggJoin982713251665043291;
