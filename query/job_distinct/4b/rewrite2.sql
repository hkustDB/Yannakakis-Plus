create or replace view semiJoinView6949683044538665950 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view tAux98 as select id as v14, title as v15 from title where production_year>2010;
create or replace view semiJoinView6384984208628045410 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView142223251829046292 as select v14, v1, v9 from semiJoinView6949683044538665950 where (v14) in (select (v14) from semiJoinView6384984208628045410);
create or replace view mi_idxAux54 as select v14, v9 from semiJoinView142223251829046292;
create or replace view semiJoinView305654678942045906 as select distinct v14, v9 from mi_idxAux54 where (v14) in (select (v14) from tAux98);
create or replace view semiEnum8361053103163171475 as select v9, v15 from semiJoinView305654678942045906 join tAux98 using(v14);
select distinct v9, v15 from semiEnum8361053103163171475;
