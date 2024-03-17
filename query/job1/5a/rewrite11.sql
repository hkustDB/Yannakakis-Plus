create or replace view aggView4945505582688053685 as select id as v3 from info_type as it;
create or replace view aggJoin8605169350949361006 as select movie_id as v15, info as v13 from movie_info as mi, aggView4945505582688053685 where mi.info_type_id=aggView4945505582688053685.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2286384944521355931 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2599972584210954111 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2286384944521355931 where mc.company_type_id=aggView2286384944521355931.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView7535599198834947964 as select v15 from aggJoin2599972584210954111 group by v15;
create or replace view aggJoin1874047897388183018 as select id as v15, title as v16 from title as t, aggView7535599198834947964 where t.id=aggView7535599198834947964.v15 and production_year>2005;
create or replace view aggView1368244788998903108 as select v15, MIN(v16) as v27 from aggJoin1874047897388183018 group by v15;
create or replace view aggJoin5844976262851506382 as select v27 from aggJoin8605169350949361006 join aggView1368244788998903108 using(v15);
select MIN(v27) as v27 from aggJoin5844976262851506382;
