create or replace view aggView1280961153592904881 as select id as v3 from info_type as it;
create or replace view aggJoin455204630720233818 as select movie_id as v15, info as v13 from movie_info as mi, aggView1280961153592904881 where mi.info_type_id=aggView1280961153592904881.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6677544908503362173 as select v15 from aggJoin455204630720233818 group by v15;
create or replace view aggJoin5135509936618026972 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView6677544908503362173 where mc.movie_id=aggView6677544908503362173.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3360615944911523125 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin29069984400181554 as select v15, v9 from aggJoin5135509936618026972 join aggView3360615944911523125 using(v1);
create or replace view aggView5265371650101754365 as select v15 from aggJoin29069984400181554 group by v15;
create or replace view aggJoin8332796924568911447 as select title as v16 from title as t, aggView5265371650101754365 where t.id=aggView5265371650101754365.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin8332796924568911447;
