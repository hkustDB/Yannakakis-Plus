create or replace view semiJoinView6461444038768007606 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view mi_idxAux1 as select v14, v9 from semiJoinView6461444038768007606;
create or replace view semiJoinView7449470765329872349 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView8314411998273005191 as select id as v14, title as v15, production_year as v18 from title AS t where (id) in (select (v14) from semiJoinView7449470765329872349) and production_year>1990;
create or replace view tAux12 as select v14, v15 from semiJoinView8314411998273005191;
create or replace view semiJoinView6317860064066020911 as select distinct v14, v15 from tAux12 where (v14) in (select (v14) from mi_idxAux1);
create or replace view semiEnum1719980391544892455 as select v15, v9 from semiJoinView6317860064066020911 join mi_idxAux1 using(v14);
select distinct v9, v15 from semiEnum1719980391544892455;
