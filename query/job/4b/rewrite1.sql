create or replace view aggView3195677343647872765 as select title as v15, id as v14 from title as t where production_year>2010;
create or replace view aggJoin2495902904227197376 as (
with aggView8792647311133172025 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView8792647311133172025 where mk.keyword_id=aggView8792647311133172025.v3);
create or replace view aggJoin4430082813909628928 as (
with aggView5618072630308668959 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5618072630308668959 where mi_idx.info_type_id=aggView5618072630308668959.v1);
create or replace view aggJoin3364339739396368595 as (
with aggView3795468426650285552 as (select v14 from aggJoin2495902904227197376 group by v14)
select v14, v9 from aggJoin4430082813909628928 join aggView3795468426650285552 using(v14));
create or replace view aggJoin9138909877575944082 as (
with aggView8749216040137024509 as (select v9, v14 from aggJoin3364339739396368595 group by v9,v14)
select v14, v9 from aggView8749216040137024509 where v9>'9.0');
create or replace view aggJoin4557056372434755510 as (
with aggView1922175529197643801 as (select v14, MIN(v15) as v27 from aggView3195677343647872765 group by v14)
select v9, v27 from aggJoin9138909877575944082 join aggView1922175529197643801 using(v14));
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin4557056372434755510;
