create or replace view tAux49 as select id as v14, title as v15 from title where production_year>2005;
create or replace view semiJoinView6604421852616417207 as select movie_id as v14, keyword_id as v3 from movie_keyword AS mk where (keyword_id) in (select (id) from keyword AS k where keyword LIKE '%sequel%');
create or replace view semiJoinView5982020622205734127 as select movie_id as v14, info_type_id as v1, info as v9 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'rating');
create or replace view semiJoinView5952302174721604646 as select v14, v1, v9 from semiJoinView5982020622205734127 where (v14) in (select (v14) from semiJoinView6604421852616417207);
create or replace view mi_idxAux76 as select v14, v9 from semiJoinView5952302174721604646;
create or replace view semiJoinView8531414464173128708 as select distinct v14, v9 from mi_idxAux76 where (v14) in (select (v14) from tAux49);
create or replace view semiEnum9218979837722514413 as select v9, v15 from semiJoinView8531414464173128708 join tAux49 using(v14);
select distinct v9, v15 from semiEnum9218979837722514413;
