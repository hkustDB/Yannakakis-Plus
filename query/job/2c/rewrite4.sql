create or replace view aggJoin4983155076177911915 as (
with aggView6232458206533531411 as (select id as v18 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v12 from movie_keyword as mk, aggView6232458206533531411 where mk.keyword_id=aggView6232458206533531411.v18);
create or replace view aggJoin115371316938897622 as (
with aggView1937743167593729061 as (select id as v1 from company_name as cn where country_code= '[sm]')
select movie_id as v12 from movie_companies as mc, aggView1937743167593729061 where mc.company_id=aggView1937743167593729061.v1);
create or replace view aggJoin5687414079582728425 as (
with aggView1028018568712749002 as (select v12 from aggJoin115371316938897622 group by v12)
select id as v12, title as v20 from title as t, aggView1028018568712749002 where t.id=aggView1028018568712749002.v12);
create or replace view aggJoin7459535376855992694 as (
with aggView2362257471081948741 as (select v12, MIN(v20) as v31 from aggJoin5687414079582728425 group by v12)
select v31 from aggJoin4983155076177911915 join aggView2362257471081948741 using(v12));
select MIN(v31) as v31 from aggJoin7459535376855992694;
