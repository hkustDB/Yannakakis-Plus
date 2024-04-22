create or replace view aggView3537921021841176021 as select title as v26, id as v11 from title as t2;
create or replace view aggView9179092943926511968 as select id as v13, title as v14 from title as t1;
create or replace view aggJoin1734574025627365365 as (
with aggView8350077888936502504 as (select v13, MIN(v14) as v38 from aggView9179092943926511968 group by v13)
select movie_id as v13, linked_movie_id as v11, link_type_id as v4, v38 from movie_link as ml, aggView8350077888936502504 where ml.movie_id=aggView8350077888936502504.v13);
create or replace view aggJoin6984169935047773077 as (
with aggView1311166197343904207 as (select v11, MIN(v26) as v39 from aggView3537921021841176021 group by v11)
select v13, v4, v38 as v38, v39 from aggJoin1734574025627365365 join aggView1311166197343904207 using(v11));
create or replace view aggJoin1617897503470904159 as (
with aggView4423549981583040866 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select movie_id as v13 from movie_keyword as mk, aggView4423549981583040866 where mk.keyword_id=aggView4423549981583040866.v8);
create or replace view aggJoin613656917532460888 as (
with aggView6771796876098551823 as (select v13 from aggJoin1617897503470904159 group by v13)
select v4, v38 as v38, v39 as v39 from aggJoin6984169935047773077 join aggView6771796876098551823 using(v13));
create or replace view aggJoin3872614428409513087 as (
with aggView5699784717064302628 as (select v4, MIN(v38) as v38, MIN(v39) as v39 from aggJoin613656917532460888 group by v4,v39,v38)
select link as v5, v38, v39 from link_type as lt, aggView5699784717064302628 where lt.id=aggView5699784717064302628.v4);
select MIN(v5) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin3872614428409513087;
