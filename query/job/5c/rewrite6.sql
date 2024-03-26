create or replace view aggView8075750118384332204 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8573391552948847919 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8075750118384332204 where mc.company_type_id=aggView8075750118384332204.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5086842762357304789 as select v15 from aggJoin8573391552948847919 group by v15;
create or replace view aggJoin5225903302858779500 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView5086842762357304789 where mi.movie_id=aggView5086842762357304789.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView1099266180668090268 as select id as v3 from info_type as it;
create or replace view aggJoin1752318275812399152 as select v15, v13 from aggJoin5225903302858779500 join aggView1099266180668090268 using(v3);
create or replace view aggView5007801432060584476 as select v15 from aggJoin1752318275812399152 group by v15;
create or replace view aggJoin3813607830618299799 as select title as v16 from title as t, aggView5007801432060584476 where t.id=aggView5007801432060584476.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin3813607830618299799;
