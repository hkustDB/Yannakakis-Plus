create or replace view semiJoinView3528742304053031901 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies AS mc where (company_type_id) in (select (id) from company_type AS ct where kind= 'production companies') and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view semiJoinView1180460711260312325 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info AS mi where (info_type_id) in (select (id) from info_type AS it) and info IN ('USA','America');
create or replace view semiJoinView2165975031184917648 as select v15, v1, v9 from semiJoinView3528742304053031901 where (v15) in (select (v15) from semiJoinView1180460711260312325);
create or replace view semiJoinView4580548134695708249 as select id as v15, title as v16, production_year as v19 from title AS t where (id) in (select (v15) from semiJoinView2165975031184917648) and production_year>2010;
create or replace view tAux93 as select v16 from semiJoinView4580548134695708249;
select distinct v16 from tAux93;
