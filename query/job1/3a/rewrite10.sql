create or replace view aggView6559979290905533758 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin322178824074892533 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6559979290905533758 where mk.movie_id=aggView6559979290905533758.v12;
create or replace view aggView6088577727765489541 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin758323287961346383 as select v12 from aggJoin322178824074892533 join aggView6088577727765489541 using(v1);
create or replace view aggView111472487391070948 as select v12 from aggJoin758323287961346383 group by v12;
create or replace view aggJoin4706570453989448767 as select title as v13 from title as t, aggView111472487391070948 where t.id=aggView111472487391070948.v12 and production_year>2005;
select MIN(v13) as v24 from aggJoin4706570453989448767;
