create or replace view aggView2394252605399880013 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin6256353133551148841 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView2394252605399880013 where mc.movie_id=aggView2394252605399880013.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView8253154152525992717 as select id as v3 from info_type as it;
create or replace view aggJoin4816927221383507489 as select movie_id as v15, info as v13 from movie_info as mi, aggView8253154152525992717 where mi.info_type_id=aggView8253154152525992717.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView8676192582593038818 as select v15 from aggJoin4816927221383507489 group by v15;
create or replace view aggJoin1322783670714845450 as select v1, v9, v27 as v27 from aggJoin6256353133551148841 join aggView8676192582593038818 using(v15);
create or replace view aggView4944719528313531560 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8902092243785130913 as select v9, v27 from aggJoin1322783670714845450 join aggView4944719528313531560 using(v1);
select MIN(v27) as v27 from aggJoin8902092243785130913;
