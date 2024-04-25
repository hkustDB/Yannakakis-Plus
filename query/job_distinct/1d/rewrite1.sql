create or replace view tAux59 as select id as v15, title as v16, production_year as v19 from title;
create or replace view semiJoinView510456216411992903 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view semiJoinView4287508198880684817 as select movie_id as v15, info_type_id as v3 from movie_info_idx AS mi_idx where (info_type_id) in (select (id) from info_type AS it where info= 'bottom 10 rank');
create or replace view semiJoinView4608042385732528208 as select v15, v1, v9 from semiJoinView510456216411992903 where (v15) in (select (v15) from semiJoinView4287508198880684817);
create or replace view mcAux17 as select v15, v9 from semiJoinView4608042385732528208;
create or replace view semiJoinView4076370667056965986 as select distinct v15, v9 from mcAux17 where (v15) in (select (v15) from tAux59);
create or replace view semiEnum6283719593322537129 as select v9, v19, v16 from semiJoinView4076370667056965986 join tAux59 using(v15);
select distinct v9, v16, v19 from semiEnum6283719593322537129;
