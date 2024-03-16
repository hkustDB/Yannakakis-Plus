create or replace view aggView812567769156574577 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8758893331742829486 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView812567769156574577 where mc.movie_id=aggView812567769156574577.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView5208466532126690723 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1667820952471687174 as select v15, v9, v27 from aggJoin8758893331742829486 join aggView5208466532126690723 using(v1);
create or replace view aggView1205058329421432689 as select v15, MIN(v27) as v27 from aggJoin1667820952471687174 group by v15;
create or replace view aggJoin3569557418183006471 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView1205058329421432689 where mi.movie_id=aggView1205058329421432689.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView9063441731569375428 as select v3, MIN(v27) as v27 from aggJoin3569557418183006471 group by v3;
create or replace view aggJoin4174395635609776950 as select v27 from info_type as it, aggView9063441731569375428 where it.id=aggView9063441731569375428.v3;
select MIN(v27) as v27 from aggJoin4174395635609776950;
