create or replace view aggView6653347356353828940 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin1847449591644980462 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView6653347356353828940 where mc.movie_id=aggView6653347356353828940.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView1594298153076716237 as select id as v3 from info_type as it;
create or replace view aggJoin7601154067299198148 as select movie_id as v15, info as v13 from movie_info as mi, aggView1594298153076716237 where mi.info_type_id=aggView1594298153076716237.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4373227203037090781 as select v15 from aggJoin7601154067299198148 group by v15;
create or replace view aggJoin6354275362627196650 as select v1, v9, v27 as v27 from aggJoin1847449591644980462 join aggView4373227203037090781 using(v15);
create or replace view aggView383846143479809463 as select v1, MIN(v27) as v27 from aggJoin6354275362627196650 group by v1;
create or replace view aggJoin333498213813970875 as select kind as v2, v27 from company_type as ct, aggView383846143479809463 where ct.id=aggView383846143479809463.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin333498213813970875;
