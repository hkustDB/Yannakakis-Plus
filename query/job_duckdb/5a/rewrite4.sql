create or replace view aggView417950181361225606 as select id as v3 from info_type as it;
create or replace view aggJoin8704947773276898255 as select movie_id as v15, info as v13 from movie_info as mi, aggView417950181361225606 where mi.info_type_id=aggView417950181361225606.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1712165366462367141 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8383656099839754180 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1712165366462367141 where mc.company_type_id=aggView1712165366462367141.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView620475118527270862 as select v15 from aggJoin8704947773276898255 group by v15;
create or replace view aggJoin5277058044353506065 as select id as v15, title as v16, production_year as v19 from title as t, aggView620475118527270862 where t.id=aggView620475118527270862.v15 and production_year>2005;
create or replace view aggView6674027824501072091 as select v15 from aggJoin8383656099839754180 group by v15;
create or replace view aggJoin4999289646764171683 as select v16 from aggJoin5277058044353506065 join aggView6674027824501072091 using(v15);
select MIN(v16) as v27 from aggJoin4999289646764171683;
