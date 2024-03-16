create or replace view aggView5976564418137088693 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8757640704083067533 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5976564418137088693 where mc.company_type_id=aggView5976564418137088693.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView1763583297835745379 as select v15 from aggJoin8757640704083067533 group by v15;
create or replace view aggJoin3128163066497864841 as select id as v15, title as v16 from title as t, aggView1763583297835745379 where t.id=aggView1763583297835745379.v15 and production_year>1990;
create or replace view aggView1894462089570123872 as select v15, MIN(v16) as v27 from aggJoin3128163066497864841 group by v15;
create or replace view aggJoin2343415799942804032 as select info_type_id as v3, v27 from movie_info as mi, aggView1894462089570123872 where mi.movie_id=aggView1894462089570123872.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5658204237006232410 as select id as v3 from info_type as it;
create or replace view aggJoin1728257565771580799 as select v27 from aggJoin2343415799942804032 join aggView5658204237006232410 using(v3);
select MIN(v27) as v27 from aggJoin1728257565771580799;
