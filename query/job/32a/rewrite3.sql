create or replace view aggJoin346186407539307805 as (
with aggView2068312556373153547 as (select id as v11, title as v39 from title as t2)
select movie_id as v13, link_type_id as v4, v39 from movie_link as ml, aggView2068312556373153547 where ml.linked_movie_id=aggView2068312556373153547.v11);
create or replace view aggJoin1809908379639137043 as (
with aggView6306371582796938209 as (select id as v4, link as v37 from link_type as lt)
select v13, v39, v37 from aggJoin346186407539307805 join aggView6306371582796938209 using(v4));
create or replace view aggJoin1869580125547030170 as (
with aggView6531872285937421945 as (select id as v8 from keyword as k where keyword= '10,000-mile-club')
select movie_id as v13 from movie_keyword as mk, aggView6531872285937421945 where mk.keyword_id=aggView6531872285937421945.v8);
create or replace view aggJoin5495002829451174458 as (
with aggView6993224665881526249 as (select v13, MIN(v39) as v39, MIN(v37) as v37 from aggJoin1809908379639137043 group by v13,v39,v37)
select id as v13, title as v14, v39, v37 from title as t1, aggView6993224665881526249 where t1.id=aggView6993224665881526249.v13);
create or replace view aggJoin94500232008005251 as (
with aggView3790532129810336249 as (select v13, MIN(v39) as v39, MIN(v37) as v37, MIN(v14) as v38 from aggJoin5495002829451174458 group by v13,v39,v37)
select v39, v37, v38 from aggJoin1869580125547030170 join aggView3790532129810336249 using(v13));
select MIN(v37) as v37,MIN(v38) as v38,MIN(v39) as v39 from aggJoin94500232008005251;
