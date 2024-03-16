create or replace view aggView3176260651270075351 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin9032565502113731216 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView3176260651270075351 where mi.movie_id=aggView3176260651270075351.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5622453173518014494 as select id as v3 from info_type as it;
create or replace view aggJoin7741987853701379923 as select v15, v13, v27 from aggJoin9032565502113731216 join aggView5622453173518014494 using(v3);
create or replace view aggView7003865623435650269 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3617187438208386975 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7003865623435650269 where mc.company_type_id=aggView7003865623435650269.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView9079590687166892969 as select v15 from aggJoin3617187438208386975 group by v15;
create or replace view aggJoin6546835115752164117 as select v13, v27 as v27 from aggJoin7741987853701379923 join aggView9079590687166892969 using(v15);
select MIN(v27) as v27 from aggJoin6546835115752164117;
