import { memo, SVGProps } from 'react';

const FrameIcon = (props: SVGProps<SVGSVGElement>) => (
  <svg preserveAspectRatio='none' viewBox='0 0 20 20' fill='none' xmlns='http://www.w3.org/2000/svg' {...props}>
    <g opacity={0.3}>
      <path
        fillRule='evenodd'
        clipRule='evenodd'
        d='M5.486 3.24431C6.82214 2.35152 8.39303 1.875 10 1.875C12.1542 1.87727 14.2195 2.73403 15.7427 4.25727C17.266 5.78051 18.1227 7.84581 18.125 10C18.125 11.607 17.6485 13.1779 16.7557 14.514C15.8629 15.8502 14.594 16.8916 13.1093 17.5065C11.6247 18.1215 9.99099 18.2824 8.4149 17.9689C6.8388 17.6554 5.39106 16.8815 4.25476 15.7452C3.11846 14.6089 2.34463 13.1612 2.03112 11.5851C1.71762 10.009 1.87852 8.37535 2.49348 6.8907C3.10844 5.40605 4.14985 4.1371 5.486 3.24431ZM6.18046 15.7164C7.31105 16.4718 8.64026 16.875 10 16.875C11.8227 16.8729 13.5702 16.1479 14.8591 14.8591C16.1479 13.5702 16.8729 11.8227 16.875 10C16.875 8.64025 16.4718 7.31104 15.7164 6.18045C14.9609 5.04987 13.8872 4.16868 12.631 3.64833C11.3747 3.12798 9.99238 2.99183 8.65876 3.2571C7.32514 3.52237 6.10013 4.17716 5.13864 5.13864C4.17716 6.10013 3.52238 7.32513 3.2571 8.65875C2.99183 9.99237 3.12798 11.3747 3.64833 12.6309C4.16868 13.8872 5.04987 14.9609 6.18046 15.7164Z'
        fill='#F7F7F7'
      />
    </g>
  </svg>
);

const Memo = memo(FrameIcon);
export { Memo as FrameIcon };
