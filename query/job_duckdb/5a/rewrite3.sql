create or replace view aggView5973400476572374922 as select id as v3 from info_type as it;
create or replace view aggJoin7505262613909125992 as select movie_id as v15, info as v13 from movie_info as mi, aggView5973400476572374922 where mi.info_type_id=aggView5973400476572374922.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView785001743753308183 as select v15 from aggJoin7505262613909125992 group by v15;
create or replace view aggJoin1738578710792838394 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView785001743753308183 where mc.movie_id=aggView785001743753308183.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3217599289522796002 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin253855876116134466 as select v15, v9 from aggJoin1738578710792838394 join aggView3217599289522796002 using(v1);
create or replace view aggView3965476703932304291 as select v15 from aggJoin253855876116134466 group by v15;
create or replace view aggJoin6402607332071329665 as select title as v16 from title as t, aggView3965476703932304291 where t.id=aggView3965476703932304291.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin6402607332071329665;
