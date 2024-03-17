create or replace view aggView1156563548720970743 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3839403442787355700 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1156563548720970743 where mc.company_type_id=aggView1156563548720970743.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView4018774266843298323 as select id as v3 from info_type as it;
create or replace view aggJoin6673999056787475422 as select movie_id as v15, info as v13 from movie_info as mi, aggView4018774266843298323 where mi.info_type_id=aggView4018774266843298323.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView194694582720504537 as select v15 from aggJoin6673999056787475422 group by v15;
create or replace view aggJoin1082187104737532020 as select id as v15, title as v16 from title as t, aggView194694582720504537 where t.id=aggView194694582720504537.v15 and production_year>1990;
create or replace view aggView2076743116809057063 as select v15, MIN(v16) as v27 from aggJoin1082187104737532020 group by v15;
create or replace view aggJoin4370937320067839492 as select v27 from aggJoin3839403442787355700 join aggView2076743116809057063 using(v15);
select MIN(v27) as v27 from aggJoin4370937320067839492;
