create or replace view semiJoinView2417370713871036663 as select movie_id as v3, keyword_id as v25 from movie_keyword AS mk where (movie_id) in (select (id) from title AS t);
create or replace view semiJoinView5151291860459809529 as select v3, v25 from semiJoinView2417370713871036663 where (v25) in (select (id) from keyword AS k where keyword= 'character-name-in-title');
create or replace view semiJoinView8125864367973387883 as select movie_id as v3, company_id as v20 from movie_companies AS mc where (company_id) in (select (id) from company_name AS cn);
create or replace view semiJoinView3130452700732498827 as select person_id as v26, movie_id as v3 from cast_info AS ci where (movie_id) in (select (v3) from semiJoinView8125864367973387883);
create or replace view semiJoinView4711510067962431860 as select v26, v3 from semiJoinView3130452700732498827 where (v3) in (select (v3) from semiJoinView5151291860459809529);
create or replace view semiJoinView921172079948134688 as select id as v26, name as v27 from name AS n where (id) in (select (v26) from semiJoinView4711510067962431860) and name LIKE '%B%';
create or replace view nAux43 as select v27 from semiJoinView921172079948134688;
select distinct v27 from nAux43;
