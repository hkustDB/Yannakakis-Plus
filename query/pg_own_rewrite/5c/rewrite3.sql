create or replace view aggView5681294571138978447 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5499711919587240307 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5681294571138978447 where mc.company_type_id=aggView5681294571138978447.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5350646712701102420 as select id as v3 from info_type as it;
create or replace view aggJoin8904285601194863406 as select movie_id as v15, info as v13 from movie_info as mi, aggView5350646712701102420 where mi.info_type_id=aggView5350646712701102420.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4618069077580221209 as select v15 from aggJoin5499711919587240307 group by v15;
create or replace view aggJoin6624399607961319209 as select id as v15, title as v16, production_year as v19 from title as t, aggView4618069077580221209 where t.id=aggView4618069077580221209.v15 and production_year>1990;
create or replace view aggView8580835799365934677 as select v15 from aggJoin8904285601194863406 group by v15;
create or replace view aggJoin5293859733722206393 as select v16 from aggJoin6624399607961319209 join aggView8580835799365934677 using(v15);
select MIN(v16) as v27 from aggJoin5293859733722206393;
