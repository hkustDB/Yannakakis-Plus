create or replace view aggView6819929742369321759 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin1434166958832127802 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView6819929742369321759 where mi.movie_id=aggView6819929742369321759.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3996843915107230827 as select v12, MIN(v24) as v24 from aggJoin1434166958832127802 group by v12;
create or replace view aggJoin6012366182998504463 as select keyword_id as v1, v24 from movie_keyword as mk, aggView3996843915107230827 where mk.movie_id=aggView3996843915107230827.v12;
create or replace view aggView9207063123585804089 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6502798093857131265 as select v24 from aggJoin6012366182998504463 join aggView9207063123585804089 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin6502798093857131265;
select sum(v24) from res;