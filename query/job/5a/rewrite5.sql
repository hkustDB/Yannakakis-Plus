create or replace view aggView2274761199166893411 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin8565228437914034333 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView2274761199166893411 where mi.movie_id=aggView2274761199166893411.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5729946996834330925 as select id as v3 from info_type as it;
create or replace view aggJoin6142595653130634062 as select v15, v13, v27 from aggJoin8565228437914034333 join aggView5729946996834330925 using(v3);
create or replace view aggView3934007077979355050 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8420233510510700672 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3934007077979355050 where mc.company_type_id=aggView3934007077979355050.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView6923214483077849783 as select v15 from aggJoin8420233510510700672 group by v15;
create or replace view aggJoin5795141255277298191 as select v27 as v27 from aggJoin6142595653130634062 join aggView6923214483077849783 using(v15);
select MIN(v27) as v27 from aggJoin5795141255277298191;
