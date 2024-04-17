create or replace view aggView8282982421307090860 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5007654873313471329 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView8282982421307090860 where mi.movie_id=aggView8282982421307090860.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView1797079176311351644 as select id as v3 from info_type as it;
create or replace view aggJoin4666034286184539008 as select v15, v13, v27 from aggJoin5007654873313471329 join aggView1797079176311351644 using(v3);
create or replace view aggView1129935126996092298 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7931681006433406652 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1129935126996092298 where mc.company_type_id=aggView1129935126996092298.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView2851041485780761405 as select v15 from aggJoin7931681006433406652 group by v15;
create or replace view aggJoin3096428348097059412 as select v27 as v27 from aggJoin4666034286184539008 join aggView2851041485780761405 using(v15);
select MIN(v27) as v27 from aggJoin3096428348097059412;
