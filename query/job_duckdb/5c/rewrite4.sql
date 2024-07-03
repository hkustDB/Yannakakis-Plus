create or replace view aggView353530292651182076 as select id as v3 from info_type as it;
create or replace view aggJoin3928706141267105720 as select movie_id as v15, info as v13 from movie_info as mi, aggView353530292651182076 where mi.info_type_id=aggView353530292651182076.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3636767209289120220 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1681059711851114639 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3636767209289120220 where mc.company_type_id=aggView3636767209289120220.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView8420563026076708412 as select v15 from aggJoin3928706141267105720 group by v15;
create or replace view aggJoin2063104474718787043 as select id as v15, title as v16, production_year as v19 from title as t, aggView8420563026076708412 where t.id=aggView8420563026076708412.v15 and production_year>1990;
create or replace view aggView9014198411587618631 as select v15 from aggJoin1681059711851114639 group by v15;
create or replace view aggJoin7779009225231440561 as select v16 from aggJoin2063104474718787043 join aggView9014198411587618631 using(v15);
select MIN(v16) as v27 from aggJoin7779009225231440561;
