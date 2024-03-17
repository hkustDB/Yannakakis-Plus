create or replace view aggView8455056858758676758 as select id as v3 from info_type as it;
create or replace view aggJoin628818284697110581 as select movie_id as v15, info as v13 from movie_info as mi, aggView8455056858758676758 where mi.info_type_id=aggView8455056858758676758.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2790704108061503528 as select v15 from aggJoin628818284697110581 group by v15;
create or replace view aggJoin591425908010165131 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView2790704108061503528 where mc.movie_id=aggView2790704108061503528.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView4009210025693092289 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1943739966323690744 as select v15, v9 from aggJoin591425908010165131 join aggView4009210025693092289 using(v1);
create or replace view aggView6865811183603463752 as select v15 from aggJoin1943739966323690744 group by v15;
create or replace view aggJoin7764939365199469691 as select title as v16 from title as t, aggView6865811183603463752 where t.id=aggView6865811183603463752.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin7764939365199469691;
