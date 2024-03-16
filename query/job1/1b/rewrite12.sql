create or replace view aggView2719633053399139665 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin8746769329072155503 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView2719633053399139665 where mi_idx.movie_id=aggView2719633053399139665.v15;
create or replace view aggView1179746501516551581 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8610946508511554469 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1179746501516551581 where mc.company_type_id=aggView1179746501516551581.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8298799224407195690 as select v15, MIN(v9) as v27 from aggJoin8610946508511554469 group by v15;
create or replace view aggJoin8533725289595273686 as select v3, v28 as v28, v29 as v29, v27 from aggJoin8746769329072155503 join aggView8298799224407195690 using(v15);
create or replace view aggView5623519568381656649 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin8533725289595273686 group by v3;
create or replace view aggJoin2675797707289534676 as select info as v4, v28, v29, v27 from info_type as it, aggView5623519568381656649 where it.id=aggView5623519568381656649.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2675797707289534676;
