create or replace view aggView5785006084940198583 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8527141793347937064 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView5785006084940198583 where mc.movie_id=aggView5785006084940198583.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView5311949339810043244 as select id as v3 from info_type as it;
create or replace view aggJoin7466456727894301708 as select movie_id as v15, info as v13 from movie_info as mi, aggView5311949339810043244 where mi.info_type_id=aggView5311949339810043244.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2956695964324007977 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4209651453631772471 as select v15, v9, v27 from aggJoin8527141793347937064 join aggView2956695964324007977 using(v1);
create or replace view aggView997100289224884152 as select v15, MIN(v27) as v27 from aggJoin4209651453631772471 group by v15;
create or replace view aggJoin27705354421446846 as select v13, v27 from aggJoin7466456727894301708 join aggView997100289224884152 using(v15);
select MIN(v27) as v27 from aggJoin27705354421446846;
