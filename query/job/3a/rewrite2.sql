create or replace view aggView1560270193397816063 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1262996370397505492 as select movie_id as v12 from movie_keyword as mk, aggView1560270193397816063 where mk.keyword_id=aggView1560270193397816063.v1;
create or replace view aggView3011783126385818169 as select v12 from aggJoin1262996370397505492 group by v12;
create or replace view aggJoin1059804947321626298 as select id as v12, title as v13, production_year as v16 from title as t, aggView3011783126385818169 where t.id=aggView3011783126385818169.v12 and production_year>2005;
create or replace view aggView3513751239339345480 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin792693343287130144 as select v13, v16 from aggJoin1059804947321626298 join aggView3513751239339345480 using(v12);
create or replace view aggView1760270101574618905 as select v13 from aggJoin792693343287130144 group by v13;
select MIN(v13) as v24 from aggView1760270101574618905;
